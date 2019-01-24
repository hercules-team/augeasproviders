# frozen_string_literal: true

shared_examples_for 'pg_hba resource' do
  it { is_expected.to have_pg_hba_resource_count(1) }

  it do
    is_expected.to contain_pg_hba('Default entry').only_with('name' => 'Default entry',
                                                             'type'      => 'local',
                                                             'user'      => 'all',
                                                             'database'  => 'all',
                                                             'ensure'    => 'present',
                                                             'method'    => 'md5',
                                                             'target'    => '/etc/postgresql/9.1/main/pg_hba.conf',
                                                             'provider'  => 'augeas')
  end
end

shared_context 'pg_hba' do
  it { is_expected.to have_pg_hba_resource_count(0) }

  let :example_params do
    { 'Default entry' => { 'type' => 'local', 'user' => 'all', 'database' => 'all', 'method' => 'md5', 'target' => '/etc/postgresql/9.1/main/pg_hba.conf' } }
  end

  context 'when pg_hba_hash is a Hash' do
    let(:params) { { pg_hba_hash: example_params } }
    let(:facts) { {} }

    include_examples 'pg_hba resource'
  end

  context 'when ::augeasproviders_pg_hba_hash is a Hash' do
    let(:params) { {} }
    let(:facts) { { augeasproviders_pg_hba_hash: example_params } }

    include_examples 'pg_hba resource'
  end
end
